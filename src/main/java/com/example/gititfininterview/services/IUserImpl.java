package com.example.gititfininterview.services;

import com.example.gititfininterview.exceptions.EmailVerificationFailedException;
import com.example.gititfininterview.exceptions.InvalidOtpException;
import com.example.gititfininterview.repositories.IUserReadRepository;
import com.example.gititfininterview.requests.RegisterRequest;
import com.gitittech.paygo.auth.api.SecurityContextProvider;
import com.gitittech.paygo.event.bus.EventPublisher;
import com.gitittech.paygo.commons.JwtTokenUtil;
import com.gitittech.paygo.commons.OTPUtil;
import com.gitittech.paygo.commons.PasswordUtil;
import com.gitittech.paygo.commons.dtos.User;
import com.gitittech.paygo.commons.dtos.UserWithToken;
import com.gitittech.paygo.commons.entities.JpaUser;
import com.gitittech.paygo.commons.events.RequestEmailVerificationEvent;
import com.gitittech.paygo.commons.events.UserLoginEvent;
import com.gitittech.paygo.commons.events.UserRegistrationEvent;
import com.gitittech.paygo.commons.exceptions.DuplicateRecordException;
import com.gitittech.paygo.commons.exceptions.NotFoundException;
import com.gitittech.paygo.commons.exceptions.UserDisabledException;
import com.gitittech.paygo.commons.mappers.IUserMapper;

import java.util.*;
import java.util.concurrent.atomic.AtomicReference;
import javax.naming.AuthenticationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class IUserImpl implements IUser {

    final private IUserReadRepository userReadRepository;

    private final OTPUtil otpUtil;

    final private JwtTokenUtil jwtTokenUtil;

    final private EventPublisher publisher;

    final private SecurityContextProvider securityContextProvider;

    @Autowired
    public IUserImpl(SecurityContextProvider securityContextProvider,
            IUserReadRepository userReadRepository,
            OTPUtil otpUtil,
            EventPublisher publisher,
            JwtTokenUtil jwtTokenUtil)
            throws Exception {
        this.userReadRepository = userReadRepository;
        this.otpUtil = otpUtil;
        this.jwtTokenUtil = jwtTokenUtil;
        this.publisher = publisher;
        this.securityContextProvider = securityContextProvider;
    }

    @Override
    public void confirmEmail(String email, String code) throws Throwable {
        Optional<JpaUser> optionalUser = userReadRepository.findByEmailOrPhoneOrBvn(email, null, null);
        optionalUser.orElseThrow(() -> new NotFoundException("user not found"));
        var user = optionalUser.get();
        if (user.getEmailVerified()) {
            throw new DuplicateRecordException("This account is already verified");
        }
        if (otpUtil.generateOTP(user.getId()) == Integer.parseInt(code)) {
            user.setIsEmailVerified(true);
            userReadRepository.save(user);
        } else {
            throw new InvalidOtpException("Invalid OTP");
        }
    }

    @Override
    public void requestEmailVerification(String email) throws Throwable {
        final var user = userReadRepository.findByEmailOrPhoneOrBvn(email, null, null)
                .orElseThrow(() -> new NotFoundException("user not found"));
        this.publisher.publishEvent(new RequestEmailVerificationEvent(this, IUserMapper.INSTANCE.toUser(user)));
    }

    @Override
    public User signup(RegisterRequest registerRequest) throws Throwable {
        final var optionalJpaUser = userReadRepository
                .findByEmailOrPhoneOrBvn(registerRequest.email(), registerRequest.phone(), registerRequest.bvn());
        if (optionalJpaUser.isPresent()) {
            throw new DuplicateRecordException("User already exists");
        }
        final var jpaUser = new JpaUser();
        jpaUser.setPhone(registerRequest.phone());
        jpaUser.setBvn(registerRequest.bvn());
        jpaUser.setEmail(registerRequest.email());
        jpaUser.setFirstName(registerRequest.firstName());
        jpaUser.setLastName(registerRequest.lastName());
        jpaUser.setMiddleName(registerRequest.middleName());
        jpaUser.setPassword(PasswordUtil.hashIt(registerRequest.password()));
        jpaUser.setCreatedBy(jpaUser.getEmail());
        jpaUser.setModifiedBy(jpaUser.getEmail());
        final var savedUser = userReadRepository
                .save(jpaUser);
        final var newUser = IUserMapper.INSTANCE.toUser(savedUser);
        this.publisher.publishEvent(new UserRegistrationEvent(this, newUser));
        return newUser;
    }

    @Override
    public UserWithToken signin(String email, String phone, String bvn, String password)
            throws Throwable {
        String encryptedPassword = PasswordUtil.hashIt(password);
        final var foundUser = userReadRepository
                .findByEmailOrPhoneOrBvn(email, phone, bvn).orElseThrow(() -> new NotFoundException("user not found"));
        if (foundUser != null && foundUser.getPassword().equals(encryptedPassword)) {
            AtomicReference<UserWithToken> userNode = new AtomicReference<>();
            if (!foundUser.getEmailVerified()) {
                this.publisher.publishEvent(new UserRegistrationEvent(this, IUserMapper.INSTANCE.toUser(foundUser)));
                throw new EmailVerificationFailedException("Check your inbox to confirm your email address");
            } else if (foundUser.getIsDisabled()) {
                throw new UserDisabledException("This account has been disabled.");
            } else {
                final var userWithToken = IUserMapper.INSTANCE.toUserWithToken(foundUser);
                final String authToken = jwtTokenUtil.generateToken(foundUser.getEmail());
                userWithToken.setAuthorization(authToken);
                userNode.set(userWithToken);
                this.publisher.publishEvent(new UserLoginEvent(this, IUserMapper.INSTANCE.toUser(foundUser)));
            }
            return userNode.get();
        } else {
            throw new AuthenticationException("Invalid login credentials");
        }
    }

    @Override
    public Optional<User> getUserProfile() throws Throwable {
        final var user = this.securityContextProvider.getContext()
                .getAuthentication()
                .getPrincipal();

        final var jpaUserOptional = userReadRepository
                .findByEmailOrPhoneOrBvn(((JpaUser) user).getUsername(), null, null);
        return jpaUserOptional.map(i -> IUserMapper.INSTANCE.toUser(i));
    }

    @Override
    public Optional<JpaUser> getJpaUser() throws Throwable {
        final var user = this.securityContextProvider.getContext()
                .getAuthentication()
                .getPrincipal();

        final var jpaUserOptional = userReadRepository
                .findByEmailOrPhoneOrBvn(((JpaUser) user).getUsername(), null, null);
        return jpaUserOptional;
    }
}

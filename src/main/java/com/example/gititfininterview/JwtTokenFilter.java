
package com.example.gititfininterview;

import com.example.gititfininterview.repositories.IUserReadRepository;
import com.gitittech.paygo.commons.JwtTokenUtil;
import com.gitittech.paygo.commons.entities.JpaUser;
import java.io.IOException;
import java.util.List;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.http.HttpHeaders;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import static org.springframework.util.StringUtils.isEmpty;
import org.springframework.web.filter.OncePerRequestFilter;

/**
 *
 * @author ambag
 */
@Component
public class JwtTokenFilter extends OncePerRequestFilter {

    private final JwtTokenUtil jwtTokenUtil;
    private final IUserReadRepository userRepo;

    public JwtTokenFilter(JwtTokenUtil jwtTokenUtil,
                          IUserReadRepository userRepo) {
        this.jwtTokenUtil = jwtTokenUtil;
        this.userRepo = userRepo;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain chain)
            throws ServletException, IOException {
        // Get authorization header and validate
        final String header = request.getHeader(HttpHeaders.AUTHORIZATION);
        if (isEmpty(header) || !header.startsWith("Bearer ")) {
            chain.doFilter(request, response);
            return;
        }

        final String token = header.split(" ")[1].trim();
        final var username = jwtTokenUtil.getUsernameFromToken(token);
        if (!jwtTokenUtil.validateToken(token, username)) {
            chain.doFilter(request, response);
            return;
        }

        JpaUser userDetails = userRepo
            .findByEmailOrPhoneOrBvn(jwtTokenUtil.getUsernameFromToken(token), null, null)
            .orElse(null);

        UsernamePasswordAuthenticationToken
            authentication = new UsernamePasswordAuthenticationToken(
                userDetails, null,
                userDetails == null ?
                    List.of() : userDetails.getAuthorities()
            );

        authentication.setDetails(
            new WebAuthenticationDetailsSource().buildDetails(request)
        );

        SecurityContextHolder.getContext().setAuthentication(authentication);
        chain.doFilter(request, response);
    }
}

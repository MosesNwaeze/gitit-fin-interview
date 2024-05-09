**User Story:** 
As a user, I want to view the contacts on my phone who are Paygo users like me. This requires uploading all my contacts to the server, where they are sorted. Upon completion, I should receive a task ID to monitor the status of the sorting process. Once sorting is complete, I should be able to retrieve the list of Paygo beneficiaries using the `getPaygoBeneficiaries` method and endpoint.

**Implementation Steps:**

1. **Upload Contacts to Server:**
   - Implement an endpoint on the server to receive contacts from users.
  
2. **Task Monitoring:**
   - Upon successful upload, the server assigns a unique task ID to the user.
   - Provide an endpoint for users to query the status of their task using the task ID.

3. **Sorting Contacts:**
   - Implement a background process on the server to sort uploaded contacts.
   - Notify users through the task status endpoint when sorting is complete.

4. **Retrieve Paygo Beneficiaries:**
   - Implement the `getPaygoBeneficiaries` method and endpoint on the server.
   - This endpoint should return a searchable list of contacts who are Paygo users.

**Considerations:**

- **Efficiency:** Implement efficient sorting algorithms to handle large volumes of contacts.
- **Feedback:** Provide clear feedback to users about the progress of their task and any errors encountered.
- **Concurrency** 100k users and 10k concurrent users
  
By following these steps and considerations, users can easily upload their contacts, monitor the sorting process, and retrieve the list of Paygo beneficiaries, enhancing their experience with the application.

**Setup**
1. Set the following environment variables:
      MYSQL_DATABASE, MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, SMTP_HOST, SMTP_PORT, SPRING_PROFILES_ACTIVE=development
2. `mvn clean install -DskipTests`
3. `mvn spring-boot:run`

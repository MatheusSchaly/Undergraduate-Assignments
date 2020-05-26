# Data-Persistence-using-DAO

Using Data Access Object (DAO) pattern in Python to persist data both in files (.bak, .dat, .dir using Shelve and .txt using Pickle) as well as in a relational database. Three main modules were created:

1. I started using the Pickle library, so there will be a module named "student_dao_file_pickle" that will use Pickle to persist data in a txt file. But I didn't like how I implemented the "delete_student" method. Because I couldn't directly select the student that I wanted to delete, so I had to create a new txt file every time, which is not good. It was then that I discovered the Shelve library.

2. The Shelve library enabled me to store objects as in a dictionary. Therefore, I could retrieve the data that I wanted. Now, with Shelve, the delete method works much better. And you can notice the differences by checking the "student_dao_file_pickle" module and the "student_dao_file_shelve".

3. The third module named "student_dao_postgres" persists the data in a relational database. It was created to mainly show the capability of DAO being able to, through a same interface "student_dao", persists the data in as many forms as you want.

I'm only a student, so don't take this repository too seriously. I did it all just to understand a little bit about data persistence in Python. Any suggestion is appreciated.


My own notes:

Data access object:

   Similar to an adapter. Connects the services with the database. Provides a superclass interface that can create concrete subclasses for different data sources to interact with. Therefore, for the application point of view, it makes no difference when it accesses a relational database or a file. Because you have programmed to an interface, not to the implementation itself.
   
   The data transfer object (DTO) is a carrier. DAO may use it to return data to the client. DAO may also use it to receive the data from the client to afterwards update the database.
   
   DTO don’t have any logic, only fields, getters and setters. They’re also not related to the database structure. Whereas domain objects can have logic and are usually related to the database structure.
   
   In our example, a DAO and DTO would be similar (if DTO was implemented), because student doesn’t have any logic, only a fields, getters and setters. Therefore, there is no need for a DTO. But we could implement DTO, for example, on get_student(), where a new student would be created (only with field, getters and setters) and the state of the student from the database would be copied into this new created DTO student. Then the DTO would be returned, instead of the student that came from the data base.

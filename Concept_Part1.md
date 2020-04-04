# Chapter 1 

## Drawbacks of using file systems to store data

1. Data redundancy and inconsistency
2. Difficulty in accessing data (No Concurrent Access to Write)
3. Data isolation, Limitation of Data Sharing 
4. Integrity problems
5. Atomicity of updates
   * e.g. Transfer of funds from one account to another should either complete or not happen at all
6. Concurrent access by multiple users
   * e.g. Two people reading a balance (say 100) and updating it by withdrawing money (say 75 each) at the same time
7. Security problems

## Database Management System (DBMS)

1. Basic Terms: 
   1. Entity: Noun, describing people (e.g. students, employees), place, object, event (e.g. Delivery of object), concept
   2. Attributes: Characteristics of an entity (e.g. ID, name, phone number for STUDENT)
   3. Data: Fact concerning the attributes of meaningful entities (real values of attributes)
   4. Information: Processed data (to derive meaningful and actionable insight, to help making decisions)
      * Informaiton can be descriptive(what already happened), predictive (based on the description what you predict) prescriptive(what you do for sth to/not to happen)
   5. Analysis: process of turning row data into information
   6. Schema: Logical grouping of related entities and associated database programs
   7. Database: organized collection of logically related entities
   8. DBMS: A software system that is used to create, maintain, and provide controlled access to user databases.
   9. RDBMS(Relatonal DBMS): DBMS that establishes relationship among entities based upon defined relationship via common attribute(s)
   10. Metadata: data that describes the properties and context of user data (data about data) [data type, size, optional/mandatory, constraint, description].
2. Example: (University Database)
   1. Add new students, instructors, and courses
   2. Register students for courses, and generate class rosters
   3. Assign grades to students, compute GPA and generate transcripts
3. Relation(TABLE)
   1. A relation is a named, two-dimensional table of data
   2. A table consists of tows (records) and columns (attribute or field)
   3. Requirements for a table to qualify as a relation:
      1. Every attribute value must be atomic (not multivalued, not composite).
      2. Every row must be unique (can't have two rows with exactly the same values for all their fields).
      3. Table and Attributes (columns) in tables must have unique names, single world, can not be reserved words, and o fnot more than 30 characters.
      4. The order of the columns must be irrelevant.
      5. The order of the rows must be irrelevant.
   4. Relational Algebra Operators
      1. Comparative operators: >, <, <=, >=, =, # (not equal ><)
      2. Logical operators: AND(^), OR(v), NOT(-l)
      3. Arithmetic operators: + -, *, /
      4. Aggregate functions: COUNT (count number of accurency), SUM, MIN, MAX, AVG




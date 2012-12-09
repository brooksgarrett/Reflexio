#  A Class which defines the 'report'.

class User
  include MongoMapper::Document

  key :username, String
  key :org, String
  key :first_name, String
  key :last_name, String
  
end

class Report
  include MongoMapper::Document
  
  key :org, String
  key :url, String
  key :state, String
  timestamps!
  key :reachable, Boolean
  key :response_code, Integer
  key :response_time, String
  key :screenshot, Binary
end
  

  


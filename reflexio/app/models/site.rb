class Site
  include Mongoid::Document
  field :org, type: String, default: 'Public'
  field :url, type: String
  field :state, type: String, default: 'Pending'
  field :timestamp, type: DateTime
  field :status, type: String, default: 'In Progress'
  field :screenshot, type: String
  field :response_code, type: Integer, default: 0
  field :response_time, type: Float, default: 0

end

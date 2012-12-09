class Site
  include Mongoid::Document
  field :org, type: String
  field :url, type: String
end

class Site < SitesController
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

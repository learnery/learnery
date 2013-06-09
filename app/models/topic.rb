class Topic < ActiveRecord::Base
  belongs_to :suggested_by, class_name: "User"
  belongs_to :presented_by, class_name: "User"
end

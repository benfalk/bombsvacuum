##
# == Overview
#
# This is each spot that is found on the field
#
class Location < ActiveRecord::Base

  belongs_to :field

end

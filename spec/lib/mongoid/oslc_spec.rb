require 'spec_helper'

class MongoDocument
  include Mongoid::Document
  include Mongoid::Oslc

end

describe Mongoid::Oslc do
  subject { MongoDocument.new }

  describe "class" do
    it "should have method #oslc_where" do
      MongoDocument.respond_to?(:oslc_where).should be_true
    end

    it "should create criteria" do
      query = MongoDocument.oslc_where('dcterms:title="Requirement"')
      query.class.should eql Mongoid::Criteria
      query.selector.should eql({"title" => "Requirement"})
    end
  end
end

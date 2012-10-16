require 'spec_helper'

describe Mongoid::Oslc::Strategy do
  let(:parser) { Mongoid::Oslc::Strategy }

  def parse_query(query, verbose = true)
    parser.to_query(query, :verbose => verbose)
  end

  it "has to_query method" do
    parser.respond_to?(:to_query).should be_true
  end

  describe "#parse" do

    it "should parse simple query" do
      parse_query('dcterms:title="requirement"').should eql({"title"=>"requirement"})
    end

    it "should parse query with conjunction" do
      parse_query('dcterms:title="requirement" and dcterms:description="first"').should eql({
        "title"=>"requirement",
        "description"=>"first"
      })
    end

    it "should parse query with other comparison_op" do
      parse_query('dcterms:created>"2010-04-01"').should eql({"created_at"=>{"$gt"=>"2010-04-01"}})
    end

    it "should parse query with boolean value" do
      parse_query('oslc_cm:closed=true').should eql({"closed"=> true})
    end

    it "should parse query with boolean value" do
      parse_query('oslc_cm:closed=false').should eql({"closed"=> false})
    end
  end
end

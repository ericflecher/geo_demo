require 'spec_helper'

describe Plan do
  it "should have a 'type' attribute" do
    @plan = Plan.create
    @plan.should respond_to :type
  end
end
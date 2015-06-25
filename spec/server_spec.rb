require File.expand_path '../spec_helper.rb', __FILE__

describe "The Sinatra Server" do



  it "should allow accessing the home page" do
    get '/'
    last_response.should be_ok
  end


end



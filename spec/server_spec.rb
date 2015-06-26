require File.expand_path '../spec_helper.rb', __FILE__

describe "The Sinatra Server" do



  it "should allow accessing the home page" do
    get '/'
    last_response.should be_ok
  end

  it "should be able to access ~/drug_counts.csv" do
  	get '/drug_counts.csv'
  	last_response.should be_ok
	end

	it "should be able to access ~/location_counts.csv" do
  	get '/location_counts.csv'
  	last_response.should be_ok
	end

	it "should be able to access ~/drug_name.csv" do
		get '/drug_name.csv'
  	last_response.should be_ok
	end

	# it "should be able to access ~/location_name.csv"
		# get '/location_name.csv'
  	# last_response.should be_ok
	# end

end



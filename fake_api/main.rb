require 'sinatra'

get '/fake' do
  send_file 'api_response.json', type: :json
end

# require files manually instead of loop over dirs
require 'net/http'
require 'json'
require 'sequel'
require './lib/common/result'
require './lib/fetchers/base'
require './lib/fetchers/fake_fetcher'
require 'dry-transformer'
require './lib/mappers/default_mapper'
require './lib/processors/default_proccesor'





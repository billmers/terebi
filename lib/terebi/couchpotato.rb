require 'cgi'
require 'json'
require 'open-uri'

module Terebi
  class CouchPotato
    include Logging
    API_URL = "http://minito.local:8082/api/628f5f4b67b74fd48aba22e2cda609c3/"

    def scan(folder)
      url = "#{API_URL}renamer.scan?async=1&#{CGI::escape(folder)}"
      logger.info "cp.scan: url=#{url}"

      result = JSON.parse(open(url).read())
      logger.info "cp.scan: result=#{result}"
    end

  end
end

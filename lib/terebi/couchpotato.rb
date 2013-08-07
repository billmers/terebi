require 'cgi'
require 'json'
require 'open-uri'

module Terebi
  class CouchPotato
    include Logging
    SCAN_URL = "http://minito.local:8082/api/628f5f4b67b74fd48aba22e2cda609c3/renamer.scan?async=1"

    def scan(folder)
      folder = CGI::escape(folder)
      url = "#{SCAN_URL}&#{folder}"

      logger.info "cp.scan: url=#{url}"
      result = JSON.parse(open(url).read())

      logger.info "cp.scan: result=#{result}"
    end

  end
end

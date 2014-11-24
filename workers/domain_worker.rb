require 'net/http'
require 'uri'
class DomainWork
  include Sidekiq::Worker
  sidekiq_options :queue => 'domain_worker', :retry => false

  def perform(id)
    domain = Domain.where(:id => id, :checked => false).limit(1)
    if domain.length > 0
      DomainWork::do_check(domain[0])
    end
  end

  def self.do_check(domain)
    domain_name = domain.domain
    uri = URI("http://panda.www.net.cn/cgi-bin/check.cgi?area_domain=#{domain_name}")
    res = Net::HTTP.get(uri)
    if res.include?('210')
      domain.update(:can_use => true, :response => res, :checked => true)
    elsif res.include?('211')
      domain.update(:can_use => false, :response => res, :checked => true)
    else
      domain.update(:can_use => false, :response => res, :checked => true) 
    end
  end

end

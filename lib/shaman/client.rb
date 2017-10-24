require 'faraday'
require 'json'

class Shaman::Client

  attr_reader :host
  attr_reader :token

  def initialize(host='127.0.0.1', token='123')
    @host  = host
    @token = token
  end

  # List all of the registered dns records
  def records
    get '/records'
  end

  # Fetch information about a particular record
  def record(domain)
    get "/records/#{domain}"
  end

  # Add a new domain record
  #
  # record:
  #   domain: Domain name to resolve
  #   records: array of objects defined as below:
  #     ttl: Seconds a client should cache for
  #     class: Record class
  #     type: Record type (A, CNAME, MX, etc)
  #     address: Address domain resolves to
  def add_record(record={})
    post '/records', record
  end

  # Update a registered domain record
  #
  # domain: domain used when registering the domain record
  # record: record following structure as explained above
  def update_record(domain, record={})
    put "/records/#{domain}", record
  end

  # Remove a registered domain
  #
  # domain: domain used when registering the domain record
  def remove_record(domain)
    delete "/records/#{domain}"
  end

  # Reset all domain records
  #
  # records: an array of records as defined above
  def reset_records(records=[])
    put '/records', records
  end

  protected

  def get(path)
    res = connection.get(path) do |req|
      req.headers['X-AUTH-TOKEN'] = token
    end

    if res.status >= 200 && res.status < 300
      from_json(res.body) rescue ""
    else
      raise "#{res.status}:#{res.body}"
    end
  end

  def post(path, payload)
    res = connection.post(path) do |req|
      req.headers['X-AUTH-TOKEN'] = token
      req.body = to_json(payload)
    end

    if res.status >= 200 && res.status < 300
      from_json(res.body) rescue ""
    else
      raise "#{res.status}:#{res.body}"
    end
  end

  def put(path, payload)
    res = connection.put(path) do |req|
      req.headers['X-AUTH-TOKEN'] = token
      req.body = to_json(payload)
    end

    if res.status >= 200 && res.status < 300
      from_json(res.body) rescue ""
    else
      raise "#{res.status}:#{res.body}"
    end
  end

  def delete(path, payload={})
    res = connection.delete(path) do |req|
      req.headers['X-AUTH-TOKEN'] = token
      if payload
        req.body = to_json(payload)
      end
    end

    if res.status >= 200 && res.status < 300
      true
    else
      raise "#{res.status}:#{res.body}"
    end
  end

  def connection
    @connection ||= ::Faraday.new(
      url: "https://#{host}:1632",
      ssl: { verify: false },
      request: { timeout: 10 }
    )
  end

  def to_json(data)
    JSON.dump(data)
  end

  def from_json(data)
    JSON.parse(data)
  end
end

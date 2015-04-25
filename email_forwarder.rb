# coding: utf-8
# This is a protocol handler for the server side of SMTP.
# Simple SMTP server example:
require 'eventmachine'
require 'mail'
require 'kconv'
require 'pry'

class EmailServer < EM::P::SmtpServer
  # @host = '172.17.10.58'
  # @host = '192.168.10.58'
  @host = '192.168.2.104'
  # @host = '10.6.102.204'
  @port = 3025
  
  def receive_plain_auth(user, pass)
    true
  end

  def get_server_domain
    @host
  end

  def get_server_greeting
    "#{@host}:#{@port} smtp server greets you with impunity!!"
  end

  def receive_sender(sender)
    current.sender = sender
    true
  end

  def receive_recipient(recipient)
    current.recipient = recipient
    true
  end

  def receive_message
    current.received = true
    current.completed_at = Time.now

    mail = Mail.read_from_string(current.data)
    options = { :address              => "smtp.gmail.com",
                :port                 => 587,
                :domain               => "smtp.gmail.com",
                :user_name            => 'terje@oya3.net',
                :password             => 'xxx',
                :authentication       => :plain,
                :enable_starttls_auto => true
              }
   mail.delivery_method(:smtp, options)
   mail.deliver
   # p [:received_email, current]
   puts "#{Time.now}:forward:#{mail.subject}"
    @current = OpenStruct.new
    true
  end

  def receive_ehlo_domain(domain)
    @ehlo_domain = domain
    true
  end

  def receive_data_command
    current.data = ""
    true
  end

  def receive_data_chunk(data)
    current.data << data.join("\n")
    true
  end

  def receive_transaction
    if @ehlo_domain
      current.ehlo_domain = @ehlo_domain
      @ehlo_domain = nil
    end
    true
  end

  def current
    @current ||= OpenStruct.new
  end

  def self.start(host = @host, port = @port)
    require 'ostruct'
    @server = EM.start_server host, port, self
  end

  def self.stop
    if @server
      EM.stop_server @server
      @server = nil
    end
  end

  def self.running?
    !!@server
  end
end

puts "start smtp server."
EM.run{ EmailServer.start }


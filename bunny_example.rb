#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"

conn = Bunny.new
conn.start

ch = conn.create_channel
q  = ch.queue("debit.02", :auto_delete => true)
x  = ch.default_exchange


x.publish("Hello!", :routing_key => q.name)

sleep 1.0
conn.close

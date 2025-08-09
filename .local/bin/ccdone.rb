#!/usr/bin/env ruby
# coding: utf-8

require 'json'

title = "[CC]タスクを完了したよ"
content = "詳細だよ"

curl_command = [
  'curl', '-X', 'POST',
  '-H', 'Content-Type: application/json',
  '-d', JSON.generate({
    topic: {
      title:,
      content:,
    },
  }),
  'https://push-notifier.sg-apps.com/api/v1/groups/maedana/topics'
]

system(*curl_command)
system('notify-send', title, content, '-u', 'critical')

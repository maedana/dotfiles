#!/usr/bin/env ruby
# coding: utf-8

require 'json'

# 標準入力からJSONを読み取ってパース
stdin_content = STDIN.read
begin
  data = JSON.parse(stdin_content)
  if data['cwd']
    project_name = File.basename(data['cwd'])
    title = "[CC] #{project_name} 要確認"
  else
    title = "[CC] 要確認"
  end
  content = data['message'] || "詳細"
rescue JSON::ParserError
  title = "[CC] 要確認"
  content = "詳細"
end

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

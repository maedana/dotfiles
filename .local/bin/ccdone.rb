#!/usr/bin/env ruby
# coding: utf-8

require 'json'

# 標準入力を読み取る
stdin_content = STDIN.read

# JSONを解析してプロジェクト名を取得
begin
  data = JSON.parse(stdin_content)
  if data['cwd']
    project_name = File.basename(data['cwd'])
    title = "[CC] #{project_name} 完了"
  else
    title = "[CC] 完了"
  end
  content = ""
rescue JSON::ParserError
  title = "[CC] 完了"
  content = ""
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

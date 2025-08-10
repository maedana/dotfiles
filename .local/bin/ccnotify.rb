#!/usr/bin/env ruby
# coding: utf-8

require 'json'

# 標準入力を読み取る
stdin_content = STDIN.read

# JSONを解析してプロジェクト名を取得
begin
  data = JSON.parse(stdin_content)
  project_name = data['cwd'] ? File.basename(data['cwd']) : ""
  
  # hook_event_nameによるサフィックス決定
  suffix = case data['hook_event_name']
           when 'Stop' then '完了'
           when 'Notification' then '要確認'
           else '通知'
           end
  
  title = project_name.empty? ? "[CC] #{suffix}" : "[CC] #{project_name} #{suffix}"
rescue JSON::ParserError
  title = "[CC] エラー"
end

curl_command = [
  'curl', '-X', 'POST',
  '-H', 'Content-Type: application/json',
  '-d', JSON.generate({
    topic: {
      title:,
      content: title, # 空では飛ばないので
    },
  }),
  'https://push-notifier.sg-apps.com/api/v1/groups/maedana/topics'
]

system(*curl_command)
system('notify-send', title, '-u', 'critical')

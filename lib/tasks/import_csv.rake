# csvファイルを扱う為に必要
require 'csv'

namespace :import_csv do
  desc "CSVデータをインポートするタスク"
  task users: :environment do
    # インポートするファイルのパス取得
    path = File.join Rails.root, "db/csv_data/csv_data.csv"
    # インポートするデータを格納するための配列
    list = []
    # CSVファイルからインポートするデータを取得し配列に格納
    CSV.foreach(path, headers: true) do |row|
      list << {
        name: row["name"],
        age: row["age"],
        address: row["address"]
      }
    end
    puts "インポート処理開始".red
    # インポートができなっ方場合の例外処理
    begin
      User.transaction do
        # 例外が発生する可能性のある処理
      User.create!(list)
      end
      puts "インポート完了".green
      # 例外処理
    rescue ActiveModel::UnknowAttributeError => invalid
      puts "インポートに失敗:UnkonwAttributeError".pink
    end  
  end
end 

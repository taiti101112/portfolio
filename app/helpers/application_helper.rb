# frozen_string_literal: true

module ApplicationHelper
  def default_meta_tags
    {
      site: 'TCG-PLACE',
      title: 'カードショップを簡単検索！',
      reverse: true,
      charset: 'utf-8',
      description: 'TCG-PLACEでは、カードショップを取り扱いタイトルや営業中などの条件をつけて検索することができ、行きたいカードショップを簡単に見つけられます。',
      keywords: 'カードショップ,カードゲーム,トレーディングカード,トレーディングカードゲーム,TCG',
      canonical: 'https://tcg-place.com',
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: 'https://tcg-place.com',
        image: image_url('ogp.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        # site: '@Twitterアカウント',
        image: image_url('ogp.png')
      }
    }
  end
end

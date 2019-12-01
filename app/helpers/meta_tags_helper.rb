# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags
    {
      site: "LogLog",
      title: "LogLog",
      reverse: true,
      charset: "utf-8",
      description: "LogLogはログを簡単に作成・共有できるWebサービスです",
      keywords: "ログ,記録,グラフ",
      canonical: request.original_url,
      separator: "|",
      og: {
        site_name: "LogLog",
        title: "LogLog",
        description: "LogLogはログを簡単に作成・共有できるWebサービスです",
        type: "website",
        url: root_url,
        image: image_url("apple-touch-icon.png"),
        locale: "ja_JP",
      },
      twitter: {
        card: "summary",
      }
    }
  end
end

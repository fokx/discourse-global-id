# frozen_string_literal: true
# name: discourse-global-id
# about:
# meta_topic_id: 316533
# version: 0.0.3
# authors: https://github.com/fokx
# url: https://github.com/fokx/discourse-global-id
# required_version: 2.7.0

gem "rb_sys", "0.9.98"
gem "parallel", "1.26.3", { require: false }
gem "ruby-progressbar", "1.13.0", { require: false }
gem "securerandom", "0.4.0", { require: true }

enabled_site_setting :discourse_global_id_enabled

after_initialize do
  DiscourseEvent.on(:post_created) do |post, opts, user|
    global_id = opts[:external_id].presence || SecureRandom.alphanumeric(SiteSetting.discourse_global_id_length)
    post.update_column(:global_id, global_id)
  end
end


# frozen_string_literal: true

gem 'autocorrect-rb', '2.11.1'
gem 'rb_sys', '0.9.98'

# name: discourse-cjk-formatter
# about: Reformat topic titles and post texts with mixed CJK and Latin characters
# meta_topic_id: TODO
# version: 0.0.1
# authors: https://github.com/fokx
# url: https://github.com/fokx/discourse-cjk-formatter
# required_version: 2.7.0

enabled_site_setting :discourse_cjk_formatter_enabled

module ::MyPluginModule
  PLUGIN_NAME = "discourse-cjk-formatter"
end

after_initialize do
  # Code which should run after Rails has finished booting

  unless SiteSetting.discourse_cjk_formatter_enabled
    NewPostManager.class_eval do
      def initialize(user, args)
        @user = user
        args[:title] = AutoCorrect.format(args[:title]) if args[:title].present? and !args[:title].frozen?
        args[:raw] = AutoCorrect.format(args[:raw]) if args[:raw].present? and !args[:raw].frozen?
        @args = args.delete_if { |_, v| v.nil? }
      end
    end

    PostRevisor.class_eval do
      alias_method :old_revise!, :revise!

      def revise!(editor, fields, opts = {})
        fields[:raw] = AutoCorrect.format(fields[:raw]) if fields[:raw].present? and !fields[:raw].frozen?
        fields[:title] = AutoCorrect.format(fields[:title]) if fields[:title].present? and !fields[:title].frozen?
        old_revise!(editor, fields, opts)
      end
    end
  end

end


# frozen_string_literal: true

# A Space that's accessible at both a branded domain and `/spaces/system-test/`:
#  - http://system-test.zinc.local
#  - http://localhost:3000/spaces/system-test/
class SystemTestSpace
  # Creates the system test space on environments that include it by default,
  # such as review apps, test, and local dev environments.
  def self.prepare
    return unless Feature.enabled?(:system_test)

    Space.find_by(name: 'System Test')&.destroy

    Blueprint.new(client: { name: 'System Test',
                            space: DEFAULT_SPACE_CONFIG.merge(
                              name: 'System Test Branded Domain',
                              branded_domain: 'system-test.zinc.local'
                            ) }).find_or_create!

    Blueprint.new(client: { name: 'System Test',
                            space: DEFAULT_SPACE_CONFIG
                              .merge(name: 'System Test') })
             .find_or_create!
  end

  DEFAULT_SPACE_CONFIG = {
    entrance: 'entrance-hall',
    utility_hookups: [
      { utility_slug: :plaid, name: 'Plaid', configuration: { client_id: "set-me", secret: "and-me", environment: 'sandbox' } },
      { utility_slug: :jitsi, name: 'Jitsi', configuration:
        { meet_domain: 'convene-videobridge-zinc.zinc.coop' } }
    ],
    members: [{ email: 'space-owner@example.com' },
              { email: 'space-member@example.com' }],
    rooms: [
      {
        name: 'Listed Room 1',
        publicity_level: :listed,
        access_level: :unlocked,
        access_code: nil,
        furniture_placements: {
          markdown_text_block: { content: '# Welcome!' },
          video_bridge: {},
          breakout_tables_by_jitsi: { names: %w[engineering design ops] }
        }
      },
      {
        name: 'Listed Room 2',
        publicity_level: :listed,
        access_level: :unlocked,
        access_code: nil,
        furniture_placements: {
          video_bridge: {}
        }
      },
      {
        name: 'Listed Locked Room 1',
        publicity_level: :listed,
        access_level: :locked,
        access_code: :secret,
        furniture_placements: {
          video_bridge: {}
        }
      },
      {
        name: 'Unlisted Room 1',
        publicity_level: :unlisted,
        access_level: :unlocked,
        access_code: nil,
        furniture_placements: {
          video_bridge: {}
        }
      },
      {
        name: 'Unlisted Room 2',
        publicity_level: :unlisted,
        access_level: :unlocked,
        access_code: nil,
        furniture_placements: {
          video_bridge: {}
        }
      },
      {
        name: 'Entrance Hall',
        publicity_level: :unlisted,
        furniture_placements: {
          markdown_text_block: { content: '# Wooo!' }
        }

      }
    ]
  }.freeze
end

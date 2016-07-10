require "redis"

module Feature
  class << self
    extend Forwardable

    def_delegators :rollout, :activate_user, :deactivate_user, :activate, :deactivate, :features

    # Delegates to Rollout, unless Redis is unavailable, then always returns
    # false indicating the feature is inactive.
    def active?(*args)
      rollout.active?(*args)
    rescue Errno::ECONNREFUSED, Redis::CannotConnectError, SocketError
      false
    end

    private

    def rollout
      @rollout ||= begin
        redis = Redis.new
        Rollout.new(redis)
      end
    end
  end
end
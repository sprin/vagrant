module Vagrant
  class Action
    module VM
      # Discards the saved state of the VM if its saved. If its
      # not saved, does nothing.
      class DiscardState
        def initialize(app, env)
          @app = app
        end

        def call(env)
          if env["vm"].vm.saved?
            env.ui.info "vagrant.actions.vm.discard_state.discarding"
            env["vm"].vm.discard_state
          end

          @app.call(env)
        end
      end
    end
  end
end

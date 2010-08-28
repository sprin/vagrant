module Vagrant
  class Action
    module VM
      # Middleware to disable all host only networks on the
      # VM
      class DisableNetworks
        def initialize(app, env)
          @app = app
          @env = env
        end

        def call(env)
          logged = false

          env["vm"].vm.network_adapters.each do |adapter|
            next if adapter.attachment_type != :host_only

            if !logged
              env.ui.info "vagrant.actions.vm.disable_networks.disabling"
              logged = true
            end

            adapter.enabled = false
            adapter.save
          end

          @app.call(env)
        end
      end
    end
  end
end

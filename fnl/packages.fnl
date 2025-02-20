(import-macros {: packadd!
                : pack
                : rock
                : use-package!
                : rock!
                : nyoom-init-modules!
                : nyoom-compile-modules!
                : unpack!
                : autocmd!} :macros)

(packadd! packer.nvim)
(local {: build} (autoload :hotpot.api.make))
(local {: init} (autoload :packer))
(local {: echo!} (autoload :core.lib.io))

;; Load packer

(echo! "Loading Packer")
(local headless (= 0 (length (vim.api.nvim_list_uis))))
(init {;; :lockfile {:enable true
       ;;            :path (.. (vim.fn.stdpath :config) :/lockfile.lua)}
       :compile_path (.. (vim.fn.stdpath :config) :/lua/packer_compiled.lua)
       :auto_reload_compiled false
       :display {:non_interactive headless}})

;; compile healthchecks

(echo! "Compiling Nyoom Doctor")
(build (vim.fn.stdpath :config) {:verbosity 0}
       (.. (vim.fn.stdpath :config) :/fnl/core/doctor.fnl)
       (fn []
         (.. (vim.fn.stdpath :config) :/lua/health.lua)))

;; packer can manage itself

;; (use-package! :EdenEast/packer.nvim {:opt true :branch :feat/lockfile})
(use-package! :wbthomason/packer.nvim {:opt true :branch :feat/lockfile})

;; libraries

(use-package! :nvim-lua/plenary.nvim {:module :plenary})
(use-package! :MunifTanjim/nui.nvim {:module :nui})
;; (use-package! :rktjmp/pact.nvim {:branch :new-clone-method})

;; include modules

(echo! "Initializing Module System")
(include :fnl.modules)
(nyoom-init-modules!)

;; To install a package with Nyoom you must declare them here and run 'nyoom sync'
;; on the command line, then restart nvim for the changes to take effect
;; The syntax is as follows: 

;; (use-package! :username/repo {:opt true
;;                               :defer reponame-to-defer
;;                               :call-setup pluginname-to-setup
;;                               :cmd [:cmds :to :lazyload]
;;                               :event [:events :to :lazyload]
;;                               :ft [:ft :to :load :on]
;;                               :requires [(pack :plugin/dependency)]
;;                               :run :commandtorun
;;                               :as :nametoloadas
;;                               :branch :repobranch
;;                               :setup (fn [])
;;                                        ;; same as setup with packer.nvim)})
;;                               :config (fn [])})
;;                                        ;; same as config with packer.nvim)})

;; ---------------------
;; Put your plugins here
;; ---------------------
(use-package! :folke/tokyonight.nvim)
(use-package! :phelipetls/jsonpath.nvim)
;; (use-package! :numToStr/Comment.nvim {:config (fn []
;;                                                 (local {: setup } (require :Comment))
;;                                                 (setup))})
;; (use-package! :kylechui/nvim-surround {:config (fn []
;;                                                  (local {: setup} (require :nvim-surround))
;;                                                  (setup))})
(use-package! :luukvbaal/nnn.nvim {:config (fn []
                                             (local {: setup} (require :nnn))
                                             (setup))})
;; (use-package! :kevinhwang91/nvim-bgf {:ft [:qf]})

;; (use-package! :glacambre/firenvim {:run (fn []
;;                                           (vim.fn.firenvim#install 0))})
                                          
;; (use-package! :rktjmp/lush.nvim)
;; (use-package! :Dkendal/nvim-treeclimber {:call-setup :nvim-treeclimber})
                                             
;; (use-package! :phaazon/notisys.nvim {:branch "v0.1"
;;                                      :call-setup :notisys})
;; (use-package! :folke/noice.nvim {:event [:VimEnter]
;;                                  :config (fn []
;;                                            (local {: setup} (require :noice))
;;                                            (setup))
;;                                  :requires [(pack :MunifTanjim/nui.nvim {:opt true})
;;                                             (pack :rcarriga/nvim-notify {:opt true})]})
;; Send plugins to packer

(echo! "Installing Packages")
(unpack!)
;; Compile modules 

(echo! "Compiling Nyoom Modules")
(nyoom-compile-modules!)

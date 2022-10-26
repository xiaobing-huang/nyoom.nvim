(import-macros {: packadd! : pack : rock : use-package! : rock! : unpack!} :macros)
(local {: echo!} (require :core.lib.io))

;; Load packer
(echo! "Loading Packer")
(packadd! packer.nvim)

;; include modules
(echo! "Compiling Modules")
(include :fnl.modules)

;; Setup packer
(echo! "Initiating Packer")
(let [packer (require :packer)]
   (packer.init {:git {:clone_timeout 300}
                 :compile_path (.. (vim.fn.stdpath :config) "/lua/packer_compiled.lua")
                 :auto_reload_compiled false
                 :display {:non_interactive true}}))

;; Core packages
(use-package! :wbthomason/packer.nvim {:opt true})
(use-package! :nvim-lua/plenary.nvim {:module :plenary})

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
(use-package! :numToStr/Comment.nvim {:config (fn []
                                                (local {: setup } (require :Comment))
                                                (setup))})
(use-package! :kylechui/nvim-surround {:config (fn []
                                                 (local {: setup} (require :nvim-surround))
                                                 (setup))})
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

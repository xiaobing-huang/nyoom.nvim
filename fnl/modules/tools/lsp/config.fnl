(import-macros {: nyoom-module-p!} :macros)
(local {: autoload} (require :core.lib.autoload))
(local {: deep-merge} (autoload :core.lib.tables))
(local lsp (autoload :lspconfig))
(local lsp-servers {})

;;; Improve UI

(set vim.lsp.handlers.textDocument/signatureHelp
     (vim.lsp.with vim.lsp.handlers.signature_help {:border :solid}))

(set vim.lsp.handlers.textDocument/hover
     (vim.lsp.with vim.lsp.handlers.hover {:border :solid}))

(fn on-attach [client bufnr]
  (import-macros {: buf-map! : autocmd! : augroup! : clear!} :macros)
  (local {: contains?} (autoload :core.lib))
  ;; Keybindings
  (local {:hover open-doc-float!
          :declaration goto-declaration!
          :definition goto-definition!
          :type_definition goto-type-definition!
          :code_action open-code-action-float!
          :references goto-references!
          :rename rename!} vim.lsp.buf)

  (buf-map! [n] "K" open-doc-float!)
  (buf-map! [nv] "<leader>ca" open-code-action-float!)
  (buf-map! [nv] "<leader>cr" rename!)
  (buf-map! [nv] "<leader>cf" vim.lsp.buf.format {:noremap true :silent true}))
  ;; (buf-map! [n] "<leader>d" open-line-diag-float!))
  ;; (buf-map! [n] "[d" goto-diag-prev!))
  ;; (buf-map! [n] "]d" goto-diag-next!)
  ;; (buf-map! [n] "<leader>gD" goto-declaration!)
  ;; (buf-map! [n] "<leader>gd" goto-definition!)
  ;; (buf-map! [n] "<leader>gt" goto-type-definition!)
  

  ;; Enable lsp formatting if available 
  ;; (nyoom-module-p! format.+onsave
  ;;   (when (client.supports_method "textDocument/formatting")
  ;;     (augroup! lsp-format-before-saving
  ;;       (clear! {:buffer bufnr})
  ;;       (autocmd! BufWritePre <buffer>
  ;;         '(vim.lsp.buf.format {:filter (fn [client] (not (contains? [:jsonls :tsserver] client.name)))
  ;;                               :bufnr bufnr})
  ;;         {:buffer bufnr})))))

;; What should the lsp be demanded of?

(local capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities.textDocument.completion.completionItem
     {:documentationFormat [:markdown :plaintext]
      :snippetSupport true
      :preselectSupport true
      :insertReplaceSupport true
      :labelDetailsSupport true
      :deprecatedSupport true
      :commitCharactersSupport true
      :tagSupport {:valueSet {1 1}}
      :resolveSupport {:properties [:documentation
                                    :detail
                                    :additionalTextEdits]}})

;;; Setup servers

(local defaults {:on_attach on-attach
                 : capabilities
                 :flags {:debounce_text_changes 150}})

;; fennel-language-server
;; (tset lsp-servers :fennel-language-server {})
;; (tset (require :lspconfig.configs) :fennel-language-server
;;       {:default_config {:cmd [:fennel-language-server]
;;                         :filetypes [:fennel]
;;                         :single_file_support true
;;                         :root_dir (lsp.util.root_pattern :fnl)
;;                         :settings {:fennel {:workspace {:library (vim.api.nvim_list_runtime_paths)}
;;                                             :diagnostics {:globals [:vim]}}}}})

;; (nyoom-module-p! clojure
;;   (table.insert lsp-servers :clojure-lsp))

;; (nyoom-module-p! java
;;   (table.insert lsp-servers :jdtls))

;; (nyoom-module-p! sh
;;   (table.insert lsp-servers :bashls))

;; (nyoom-module-p! julia
;;   (table.insert lsp-servers :julials))

;; (nyoom-module-p! kotlin
;;   (table.insert lsp-servers :kotlin_language_server))

;; (nyoom-module-p! latex
;;   (table.insert lsp-servers :texlab))

;; (nyoom-module-p! markdown
;;   (table.insert lsp-servers :marksman))

;; (nyoom-module-p! nim
;;   (table.insert lsp-servers :nimls))
;;
;; (nyoom-module-p! nix
;;   (table.insert lsp-servers :rnix))
;;
;; (nyoom-module-p! python
;;   (table.insert lsp-servers :pyright))

;; (nyoom-module-p! zig
;;   (table.insert lsp-servers :zls))

(table.insert lsp-servers :lemminx)
(table.insert lsp-servers :jsonls)
(table.insert lsp-servers :awk_ls)
(table.insert lsp-servers :clojure_lsp)
(table.insert lsp-servers :bashls)
  
(lsp.sumneko_lua.setup {:on_attach on-attach
                          : capabilities
                          :settings {:Lua {:diagnostics {:globals {1 :vim}}
                                           :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                                                 (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true
                                                                 (vim.fn.expand :$HOME/.hammerspoon/Spoons/EmmyLua.spoon/annotations) true}
                                                       :maxPreload 100000
                                                       :preloadFileSize 10000}}}})

;; Load lsp

;; for trickier servers you can change up the defaults
;; (nyoom-module-p! lua
  ;; (lsp.sumneko_lua.setup {:on_attach on-attach
  ;;                         : capabilities
  ;;                         :settings {:Lua {:diagnostics {:globals {1 :vim}}
  ;;                                          :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
  ;;                                                                (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}
  ;;                                                      :maxPreload 100000
  ;;                                                      :preloadFileSize 10000}}}}))
;; (lsp.jsonls.setup {:get_root_dir "123"})
;; (set lsp.jsonls.get_root_dir vim.loop.cwd)
;; (print (vim.inspect lsp.jsonls))

{: on-attach}

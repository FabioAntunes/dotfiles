function toggle-js-configs
  set basePath (string join '' $DOTFILES '/tilde/')

  if test (string join '' $basePath '.eslintrc.js') = (readlink ~/.eslintrc.js)
    ln -Fs (string join '' $basePath '.eslintrc-semi-noop.js') ~/.eslintrc.js
    ln -Fs (string join '' $basePath '.prettierrc-semi-noop.json') ~/.prettierrc.json
  else
    ln -Fs (string join '' $basePath '.eslintrc.js') ~/.eslintrc.js
    ln -Fs (string join '' $basePath '.prettierrc.json') ~/.prettierrc.json
  end
end

function toggle-js-configs
  set basePath (string join '' $DOTFILES '/tilde/')

  if test (string join '' $basePath '.eslintrc.js') = (readlink ~/.eslintrc.js)
    ln -Fs (string join '' $basePath '.eslintrc-semi-noop.js') ~/.eslintrc.js
    ln -Fs (string join '' $basePath '.prettierrc-semi-noop.js') ~/.prettierrc.js
  else
    ln -Fs (string join '' $basePath '.eslintrc.js') ~/.eslintrc.js
    ln -Fs (string join '' $basePath '.prettierrc.js') ~/.prettierrc.js
  end
end

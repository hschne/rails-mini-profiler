import babel from '@rollup/plugin-babel'
import eslint from '@rollup/plugin-eslint'
import resolve from '@rollup/plugin-node-resolve'
import commonjs from '@rollup/plugin-commonjs'
import replace from '@rollup/plugin-replace'
import { terser } from 'rollup-plugin-terser'
import scss from 'rollup-plugin-scss'
import postcss from 'rollup-plugin-postcss'
import autoprefixer from 'autoprefixer'
import copy from 'rollup-plugin-copy'

import pkg from './package.json'

const banner =
  `/*
 * Rails Mini Profiler
 * ${pkg.description}
 * ${pkg.repository.url}
 * v${pkg.version}
 * ${pkg.license} License
 */
`

const plugins = [
  resolve(),
  commonjs(),
  eslint({
    fix: true,
    exclude: ['./node_modules/**', './app/javascript/stylesheets/**'],
  }),
  babel({
    exclude: 'node_modules/**',
    babelHelpers: 'bundled'
  }),
  replace({
    'ENV': JSON.stringify(process.env.NODE_ENV || 'development'),
    'process.env.NODE_ENV': JSON.stringify('production'),
    preventAssignment: true
  }),
  (process.env.NODE_ENV === 'production' && terser()),
  scss({
     outputStyle: (process.env.NODE_ENV === 'production') ? 'compressed' : 'expanded',
  }),
  postcss({
    plugins: [autoprefixer()],
    inject: false,
    extract: true,
    sourceMap: (process.env.NODE_ENV === 'production' ? false : 'inline'),
    minimize: (process.env.NODE_ENV === 'production')
  }),
  copy({
      targets: [
        { src: './app/javascript/images/**/*', dest: './dist/images' },
        { src: './app/javascript/images/**/*', dest: './vendor/assets/images' }
      ]
    })

]

const input = 'app/javascript/packs/rails-mini-profiler.js'

export default [
  {
    input: input,
    context: 'window',
    output: {
      file: pkg.main,
      format: 'umd',
      name: 'RailsMiniProfiler',
      sourcemap: (process.env.NODE_ENV === 'production' ? false : 'inline'),
      banner: banner,
    },
    plugins: plugins
  },
  {
    input: input,
    context: 'window',
    output: {
      file: "vendor/assets/javascripts/rails-mini-profiler.js",
      format: 'umd',
      name: 'RailsMiniProfiler',
      sourcemap: (process.env.NODE_ENV === 'production' ? false : 'inline'),
      banner: banner,
    },
    plugins: plugins
  }
]

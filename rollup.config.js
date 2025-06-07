import babel from "@rollup/plugin-babel";
import eslint from "@rollup/plugin-eslint";
import resolve from "@rollup/plugin-node-resolve";
import commonjs from "@rollup/plugin-commonjs";
import replace from "@rollup/plugin-replace";
import scss from "rollup-plugin-scss";
import copy from "rollup-plugin-copy";

import pkg from "./package.json";

const banner = `/*
 * Rails Mini Profiler
 * ${pkg.description}
 * ${pkg.repository.url}
 * v${pkg.version}
 * ${pkg.license} License
 */
`;

const plugins = [
  resolve(),
  commonjs(),
  eslint({
    fix: true,
    exclude: ["./node_modules/**", "./app/javascript/stylesheets/**"],
  }),
  babel({
    exclude: "node_modules/**",
    babelHelpers: "bundled",
  }),
  replace({
    ENV: JSON.stringify(process.env.NODE_ENV || "development"),
    "process.env.NODE_ENV": JSON.stringify("production"),
    preventAssignment: true,
  }),
  scss({
    fileName: "rails-mini-profiler.css",
  }),
  copy({
    targets: [
      { src: "./app/javascript/images/**/*", dest: "./dist/images" },
      { src: "./app/javascript/images/**/*", dest: "./vendor/assets/images" },
    ],
  }),
];

const input = "app/javascript/packs/rails-mini-profiler.js";

export default [
  {
    input: input,
    context: "window",
    output: {
      dir: "vendor/assets/javascripts",
      format: "umd",
      name: "RailsMiniProfiler",
      sourcemap: process.env.NODE_ENV === "production" ? false : "inline",
      banner: banner,
    },
    plugins: plugins,
  },
];

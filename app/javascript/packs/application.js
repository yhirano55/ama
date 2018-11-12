import "babel-polyfill"
import "core-js/fn/object/assign"
import "core-js/fn/set"
import "core-js/fn/map"
import "core-js/fn/promise"
import "core-js/fn/array/find"
import "core-js/fn/array/from"
import "element-closest"

if (process.env.SENTRY_PUBLIC_DSN) {
  const Raven = require("raven-js")
  Raven.config(process.env.SENTRY_PUBLIC_DSN).install()
}

import "bootstrap"

import Rails from "rails-ujs"
Rails.start()

import Turbolinks from "turbolinks"
Turbolinks.start()
Turbolinks.setProgressBarDelay()

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
const application = Application.start()
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

import "stylesheets/application"

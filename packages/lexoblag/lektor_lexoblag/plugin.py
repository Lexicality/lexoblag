from __future__ import annotations

from jinja2.environment import Environment
from lektor.pluginsystem import Plugin

from .jinja_globals import get_breadcrumbs


class LexoblagPlugin(Plugin):
	name = "lexoblag"

	def on_setup_env(self, **extra) -> None:
		env: Environment = self.env.jinja_env
		env.globals["get_breadcrumbs"] = get_breadcrumbs
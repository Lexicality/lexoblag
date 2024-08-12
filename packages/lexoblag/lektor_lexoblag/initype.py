from __future__ import annotations

from inifile import IniData, default_dialect
from lektor.types import RawValue, Type


class IniType(Type):
	widget = "multiline-text"

	def value_from_raw(self, raw: RawValue):
		return IniData(
			default_dialect.dict_from_iterable((raw.value or "").splitlines()),
			default_dialect,
		)

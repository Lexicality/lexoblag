from __future__ import annotations

from typing import TypedDict, cast

from lektor.db import Record
from lektor.pagination import Pagination


class Breadcrumb(TypedDict):
	current: bool
	url: str
	title: str
	depth: int


def _breadcrumb(
	current_page: Record,
	crumb_record: Record,
	is_current: bool,
) -> Breadcrumb:
	title = crumb_record["title"]
	if "breadcrumb" in crumb_record:
		breadcrumb = crumb_record["breadcrumb"]
		if breadcrumb:
			title = breadcrumb
	return {
		"depth": 0,
		"current": is_current,
		"title": title,
		"url": current_page.url_to(crumb_record),
	}


def get_breadcrumbs(page: Record) -> list[Breadcrumb]:
	crumbs: list[Breadcrumb] = []
	try:
		pagination = cast(Pagination, page.pagination)
	except (AttributeError, RuntimeError):
		pagination = None

	if pagination is not None and pagination.page > 1:
		crumbs.append(
			{
				"depth": 1,
				"current": True,
				"title": f"Page {pagination.page:n}",
				"url": page.url_to(page),
			},
		)
		crumbs.append(
			_breadcrumb(
				page,
				pagination.for_page(1),  # type: ignore # 🙄
				False,
			),
		)
	else:
		crumbs.append(_breadcrumb(page, page, True))
		# TODO: categories go here

	crumb_page: Record | None = getattr(page, "parent", None)
	while crumb_page is not None:
		crumbs.append(_breadcrumb(page, crumb_page, False))
		crumb_page = getattr(crumb_page, "parent", None)

	crumbs.reverse()

	for index, crumb in enumerate(crumbs):
		crumb["depth"] = index + 1

	return crumbs

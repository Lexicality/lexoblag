class Jekyll::CodeNormalizer < Jekyll::Converters::Markdown
	def convert(content)
		super
			.gsub(/
				<div						# Start of this hell expression
					([^>]*)					# Any crap inserted via IALs
					class="
						(language-(\w+))?	# What language the user picked
						\ ?					# Unwanted space from the language selector
						([^"]*)				# More IAL crap
						highlighter-rouge	# Actual highlighter
					"
					([^>]*)					# Yet more IAL crap
				>
				(<table.*?<\/table>)			# The actual highlighted code
				<\/div>
			/xm, '<figure \1class="\4highlight"\5><pre><code class="\2" data-lang="\3">\6</code></pre></figure>')
			.gsub(/
				<code
					([^>]*)					# Any crap inserted via IALs
					class="
						([^"]*?)			# More IAL crap
						(language-(\w+) )?	# What language the user picked
						([^"]*)				# Even more IAL crap
						highlighter-rouge	# Actual highlighter
					"
					(.+?)
				<\/code>
			/x,
			'<code\1class="\2\3\5highlight" data-lang="\4"\6</code>')
	end
end

set -U fish_greeting

function vim
	nvim $argv
end

function diff
	git diff
end

function remove_branches
	git branch | xargs git branch -D
end

function pbcopy
	xsel --clipboard --input
end

function pbpaste
	xsel --clipboard --output
end

function send
	if test (count $argv) -eq 0
		echo "Please, provide commit message"
	end

	git add --all
	git commit -am $argv
	git push origin HEAD
end

if status is-interactive

end

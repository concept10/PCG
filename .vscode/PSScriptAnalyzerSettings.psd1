@{
    # Use Severity levels to specify which rules to run
    Severity     = @('Error', 'Warning', 'Information')

    # Specify which rules to include/exclude
    IncludeRules = @(
        'PSAvoidUsingCmdletAliases',
        'PSAvoidUsingPositionalParameters',
        'PSProvideCommentHelp',
        'PSUseDeclaredVarsMoreThanAssignments',
        'PSUseCmdletCorrectly',
        'PSUseConsistentIndentation',
        'PSUseConsistentWhitespace',
        'PSUseCorrectCasing',
        'PSUseSingularNouns',
        'PSReservedCmdletChar',
        'PSReservedParams',
        'PSAvoidTrailingWhitespace'
    )

    # Configure rules
    Rules        = @{
        PSUseConsistentIndentation = @{
            Enable          = $true
            Kind            = 'space'
            IndentationSize = 4
        }

        PSUseConsistentWhitespace  = @{
            Enable          = $true
            CheckInnerBrace = $true
            CheckOpenBrace  = $true
            CheckOpenParen  = $true
            CheckOperator   = $true
            CheckPipe       = $true
            CheckSeparator  = $true
        }

        PSUseCorrectCasing         = @{
            Enable = $true
        }

        PSProvideCommentHelp       = @{
            Enable                  = $true
            ExportedOnly            = $false
            BlockComment            = $true
            VSCodeSnippetCorrection = $true
            Placement               = 'before'
        }

        PSAvoidUsingCmdletAliases  = @{
            allowlist = @()
        }
    }
}

$Credential = Get-Credential

function New-ScheduledScript {
    param (
        [String]$Name,
        [String]$FilePath,
        [pscredential]$Credential,
        [Array]$Days,
        [datetime]$Time,
        [string]$Computername = "localhost"
    )

    if (Test-Connection $Computername -Count 1 -Quiet) {
        return Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
            param(
                [Parameter(Position = 0)]
                $At,
                [Parameter(Position = 1)]
                $DaysOfWeek,
                [Parameter(Position = 2)]
                $Name,
                [Parameter(Position = 3)]
                $FilePath
            )
    
            $Trigger = New-JobTrigger -Weekly -At $At -DaysOfWeek $DaysOfWeek
            Register-ScheduledJob -Name $Name -FilePath $FilePath -Trigger $Trigger
        } -ArgumentList $Time, $Days, $Name, $FilePath
    }

}

function New-ScheduledScript2 {
    param (
        [String]$Name,
        [String]$FilePath,
        [pscredential]$Credential,
        [Array]$Days,
        [datetime]$Time,
        [string]$Computername = "localhost"
    )

    if (Test-Connection $Computername -Count 1 -Quiet) {
        return Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
            param(
                [Parameter(Position = 0)]
                $At,
                [Parameter(Position = 1)]
                $DaysOfWeek,
                [Parameter(Position = 2)]
                $Name,
                [Parameter(Position = 3)]
                $FilePath
            )
    
            $Trigger = New-ScheduledTaskTrigger -Weekly -At $At -DaysOfWeek $DaysOfWeek
            $Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument $FilePath
            Register-ScheduledTask -TaskName $Name -Trigger $Trigger -Action $Action -RunLevel Highest –Force

        } -ArgumentList $Time, $Days, $Name, $FilePath
    }

}

$NSC = @{
    Name         = "Test123"
    FilePath     = "C:\test.ps1"
    Credential   = $Credential
    Days         = @("Monday", "Tuesday")
    Time         = "9:00 PM"
    ComputerName = "winser02"
}
New-ScheduledScript2 @NSC




function Get-ScheduledScript {
    param (
        [string]$Computername = "localhost",
        [string]$Name = "*",
        [pscredential]$Credential
    )

    if (Test-Connection $Computername -Count 1 -Quiet) {
        return Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
            param(
                [Parameter(Position = 0)]
                $Name
            )
            Get-ScheduledJob -Name $Name
        } -ArgumentList $Name
    }
}

function Get-ScheduledScript2 {
    param (
        [string]$Computername = "localhost",
        [string]$Name = "*",
        [pscredential]$Credential
    )

    if (Test-Connection $Computername -Count 1 -Quiet) {
        return Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
            param(
                [Parameter(Position = 0)]
                $Name
            )
            Get-ScheduledTask -TaskName $Name
        } -ArgumentList $Name
    }
}

$GSC = @{
    Name         = "Test123"
    Credential   = $Credential
    ComputerName = "winser03"
}
Get-ScheduledScript2 @GSC



function Set-ScheduledScript {
    param (
        [String]$Name,
        [String]$FilePath,
        [pscredential]$Credential,
        [Array]$Days,
        [datetime]$Time,
        [string]$Computername = "localhost"
    )

    if (Test-Connection $Computername -Count 1 -Quiet) {
        return Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
            param(
                [Parameter(Position = 0)]
                $At,
                [Parameter(Position = 1)]
                $DaysOfWeek,
                [Parameter(Position = 2)]
                $Name,
                [Parameter(Position = 3)]
                $FilePath
            )
            Write-Host $FilePath
            $Trigger = New-JobTrigger -Weekly -At $At -DaysOfWeek $DaysOfWeek
            Get-ScheduledJob -Name $Name | Set-ScheduledJob -FilePath $FilePath -Trigger $Trigger
            
        } -ArgumentList $Time, $Days, $Name, $FilePath
    }
}

function Set-ScheduledScript2 {
    param (
        [String]$Name,
        [String]$FilePath,
        [pscredential]$Credential,
        [Array]$Days,
        [datetime]$Time,
        [string]$Computername = "localhost"
    )

    if (Test-Connection $Computername -Count 1 -Quiet) {
        return Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
            param(
                [Parameter(Position = 0)]
                $At,
                [Parameter(Position = 1)]
                $DaysOfWeek,
                [Parameter(Position = 2)]
                $Name,
                [Parameter(Position = 3)]
                $FilePath
            )

            $Trigger = New-ScheduledTaskTrigger -Weekly -At $At -DaysOfWeek $DaysOfWeek
            $Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument $FilePath
            Set-ScheduledTask -TaskName $Name -Trigger $Trigger -Action $Action

        } -ArgumentList $Time, $Days, $Name, $FilePath
    }
}


$SSC = @{
    Name         = "Test123"
    FilePath     = "C:\test123.ps1"
    Credential   = $Credential
    Days         = @("Monday", "Tuesday")
    Time         = "9:00 PM"
    ComputerName = "winser03"
}
Set-ScheduledScript2 @SSC





<# Function Get-ScheduledScript {
    Get-ScheduledJob
}

# Other
Register-ScheduledJob
New-ScheduledJobOption
New-JobTrigger -Weekly
 #>


##

Set-ScheduledJob

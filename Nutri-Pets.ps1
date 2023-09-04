# Importar los módulos necesarios
Import-Module BitsTransfer
Import-Module NetAdapter
Import-Module Appx

# Crear la interfaz gráfica
Add-Type -AssemblyName System.Windows.Forms
$form = New-Object System.Windows.Forms.Form
$form.Text = "Administrador de dispositivos"
$form.Width = 500
$form.Height = 400
$form.StartPosition = "CenterScreen"

$URLLabel = New-Object System.Windows.Forms.Label
$URLLabel.Location = New-Object System.Drawing.Point(10,50)
$URLLabel.Size = New-Object System.Drawing.Size(80,20)
$URLLabel.Text = "Introduzca la URL del archivo que desea descargar"
$loginForm.Controls.Add($URLLabel)

$URLBox = New-Object System.Windows.Forms.TextBox
$URLBox.Location = New-Object System.Drawing.Point(90,50)
$URLBox.Size = New-Object System.Drawing.Size(180,20)
$URLBox.Controls.Add($URLBox)

$fileLabel = New-Object System.Windows.Forms.Label
$fileLabel.Location = New-Object System.Drawing.Point(10,50)
$fileLabel.Size = New-Object System.Drawing.Size(80,20)
$fileLabel.Text = "Introduzca la URL del archivo que desea descargar"
$loginForm.Controls.Add($fileLabel)

$fileBox = New-Object System.Windows.Forms.TextBox
$fileBox.Location = New-Object System.Drawing.Point(90,50)
$fileBox.Size = New-Object System.Drawing.Size(180,20)
$fileBox.Controls.Add($fileBox)

$btn1 = New-Object System.Windows.Forms.Button
$btn1.Location = New-Object System.Drawing.Point(10,10)
$btn1.Size = New-Object System.Drawing.Size(100,50)
$btn1.Text = "Descargar archivo"
$form.Controls.Add($btn1)
$btn2 = New-Object System.Windows.Forms.Button
$btn2.Location = New-Object System.Drawing.Point(10,70)
$btn2.Size = New-Object System.Drawing.Size(100,50)
$btn2.Text = "Desinstalar aplicación"
$form.Controls.Add($btn2)
$btn3 = New-Object System.Windows.Forms.Button
$btn3.Location = New-Object System.Drawing.Point(10,130)
$btn3.Size = New-Object System.Drawing.Size(100,50)
$btn3.Text = "Configurar adaptador de red"
$form.Controls.Add($btn3)
$btn4 = New-Object System.Windows.Forms.Button
$btn4.Location = New-Object System.Drawing.Point(10,190)
$btn4.Size = New-Object System.Drawing.Size(100,50)
$btn4.Text = "Salir"
$form.Controls.Add($btn4)

# Definir las funciones que se ejecutarán al presionar los botones
$btn1.Add_Click({
    Start-BitsTransfer -Source $url -Destination $file | Out-GridView
})

$btn2.Add_Click({
    $appName = Read-Host "Introduzca el nombre de la aplicación que desea desinstalar" | Out-GridView
    Get-AppxPackage -Name $appName | Remove-AppxPackage | Out-GridView
})

$btn3.Add_Click({
    $adapterName = Read-Host "Introduzca el nombre del adaptador de red que desea configurar"| Out-GridView
    $ipv4Address = Read-Host "Introduzca la dirección IPv4 que desea asignar"| Out-GridView
    $subnetMask = Read-Host "Introduzca la máscara de subred que desea asignar"| Out-GridView
    $dnsServers = Read-Host "Introduzca las direcciones de los servidores DNS separados por comas"| Out-GridView
    Set-NetIPAddress -InterfaceAlias $adapterName -IPAddress $ipv4Address -PrefixLength $subnetMask| Out-GridView
    Set-DnsClientServerAddress -InterfaceAlias $adapterName -ServerAddresses ($dnsServers -split ',') | Out-GridView
})

$btn4.Add_Click({
    $form.Close()
})
# Mostrar la interfaz gráfica
$form.ShowDialog() | Out-Null
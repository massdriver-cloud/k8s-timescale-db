apiVersion: v1
kind: Config
current-context: ${current_context}
clusters:
%{ for cluster in clusters ~}
- cluster:
    certificate-authority-data: ${cluster.certificate_authority_data}
    server: ${cluster.server}
  name: ${cluster.name}
%{~ endfor }
contexts:
%{ for context in contexts ~}
- context:
    %{~ if context.cluster_name != null ~}
    cluster: ${context.cluster_name}
    %{~ endif ~}
    %{~ if context.user != null ~}
    user: ${context.user}
    %{~ endif ~}
  name: ${context.name}
%{~ endfor }
users:
%{ for user in users ~}
- name: ${user.name}
  user:
    %{~ if user.token != null ~}
    token: ${user.token}
    %{~ endif ~}
%{~ endfor ~}

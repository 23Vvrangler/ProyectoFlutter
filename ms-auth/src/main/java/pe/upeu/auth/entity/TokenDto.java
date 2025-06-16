package pe.upeu.auth.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class TokenDto {
    private String token;
    private String userName; // Campo para el nombre de usuario
    private String role;     // Campo para el rol del usuario

    public TokenDto(String token) {
        this.token = token;
        // Los otros campos (userName, role) se quedarán como null en este constructor
    }
}

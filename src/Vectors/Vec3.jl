# Real Valued 3D Vector Type
mutable struct Vec3{T} <: AbstractVector{T}
    x::T
    y::T
    z::T
end

# Constructors
Vec3(x::T) where T = Vec3{T}(x, x, x)  # Uniform 3D vector

# Base functions
Base.getindex(v::Vec3, i::Int) = i == 1 ? v.x : i == 2 ? v.y : v.z # Get element at index i
Base.setindex!(v::Vec3, val, i::Int) = i == 1 ? (v.x = val) : i == 2 ? (v.y = val) : (v.z = val) # Set element at index i

# Vector operations
dot(v1::Vec3, v2::Vec3) = v1.x * v2.x + v1.y * v2.y + v1.z * v2.z # Dot product
norm(v::Vec3) = sqrt(v.x^2 + v.y^2 + v.z^2) # Norm

function normalize(v::Vec3)
    n = norm(v)
    return n == 0 ? Vec3(zero(eltype(v))) : v / n
end

cross(v1::Vec3, v2::Vec3) = Vec3(
    v1.y * v2.z - v1.z * v2.y,
    v1.z * v2.x - v1.x * v2.z,
    v1.x * v2.y - v1.y * v2.x
) # Cross product

# Arithmetic operations
Base.:+(v1::Vec3, v2::Vec3) = Vec3(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z) # Addition
Base.:-(v1::Vec3, v2::Vec3) = Vec3(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z)  # Subtraction
Base.:*(a::T, v::Vec3) where T <: Number = Vec3(a * v.x, a * v.y, a * v.z) # Scalar multiplication
Base.:*(v::Vec3, a::T) where T <: Number = Vec3(a * v.x, a * v.y, a * v.z) # Scalar multiplication
Base.:/(v::Vec3, a::T) where T <: Number = Vec3(v.x / a, v.y / a, v.z / a) # Scalar division
Base.:-(v::Vec3) = Vec3(-v.x, -v.y, -v.z) # Negation
Base.:+(v::Vec3, a::T) where T = Vec3(v.x + a, v.y + a, v.z + a) # Add scalar
Base.:+(V::Vec3, v2::Vector) = Vec3(V.x + v2[1], V.y + v2[2], V.z + v2[3]) # Add vector
Base.:-(v::Vec3, a::T) where T = Vec3(v.x - a, v.y - a, v.z - a) # Subtract scalar
Base.:+(a::T, v::Vec3) where T = Vec3(a + v.x, a + v.y, a + v.z) # Add scalar
Base.:*(v1::Vec3, v2::Vec3) = Vec3(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z) # Element-wise multiplication

# Comparison operations
Base.:(==)(v1::Vec3, v2::Vec3) = v1.x == v2.x && v1.y == v2.y && v1.z == v2.z # Equality
Base.:(!=)(v1::Vec3, v2::Vec3) = !(v1 == v2) # Inequality

Base.abs(v::Vec3) = Vec3(abs(v.x), abs(v.y), abs(v.z)) # Absolute value
Base.sign(v::Vec3) = Vec3(sign(v.x), sign(v.y), sign(v.z)) # Sign
Base.min(v1::Vec3, v2::Vec3) = Vec3(min(v1.x, v2.x), min(v1.y, v2.y), min(v1.z, v2.z)) # Element-wise minimum
Base.max(v1::Vec3, v2::Vec3) = Vec3(max(v1.x, v2.x), max(v1.y, v2.y), max(v1.z, v2.z)) # Element-wise maximum
distance(v1::Vec3, v2::Vec3) = norm(v1 - v2) # Distance

Base.size(v::Vec3) = (3,) # Size of the vector

# Print
Base.show(io::IO, v::Vec3) = print(io, "Vec3{", eltype(v), "}(", v.x, ", ", v.y, ", ", v.z, ")")
Base.show(io::IO, ::MIME"text/plain", v::Vec3) = show(io, v)
Base.show(io::IO, ::MIME"text/html", v::Vec3) = show(io, v)

# Reflection
function reflect(v::Vec3, n::Vec3)
    v - 2 * dot(v, n) * n
end

# Refraction
function refract(v::Vec3, n::Vec3, eta::T) where T
    uv = normalize(v)
    dt = dot(uv, n)
    discriminant = 1.0 - eta^2 * (1.0 - dt^2)
    if discriminant > 0
        return eta * (uv - n * dt) - n * sqrt(discriminant)
    else
        return Vec3(zero(T))
    end
end